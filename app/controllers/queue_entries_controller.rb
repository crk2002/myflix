class QueueEntriesController < ApplicationController

  before_action :page_requires_authenticated_user
  before_action :set_video, only: [:create, :destroy]

  def index
    @queue_entries = current_user.queue_entries
  end
  
  def create
    qe = current_user.queue_entries.new(video: @video, position: set_default_position)
    if qe.save 
     redirect_to user_queue_path, notice: "The video #{@video.title} was added to your queue."
    else
      flash[:error] = "Unable to add video to queue for the following reasons: #{qe.errors.full_messages}."
      redirect_to video
    end
  end
  
  def destroy
    qe = current_user.queue_entries.find_by(video: @video)
    if qe.destroy
      current_user.normalize_queue_positions
      redirect_to user_queue_path, notice: "The video #{@video.title} was successfully removed from your queue."
    else
      flash[:error] = "Unable to remove video from queue; an error occurred."
      redirect_to user_queue_path
    end
  end
  
  def update
    update_queue_positions
    current_user.normalize_queue_positions
    redirect_to user_queue_path
  end
  
  private
  
  def update_queue_positions
    queue_entries = params[:queue_entries]
    QueueEntry.transaction do
      queue_entries.each do |queue_entry_data|
        queue_entry = QueueEntry.where(id: queue_entry_data[:id], user: current_user).first
        raise ActiveRecord::Rollback if queue_entry.nil?
        queue_entry.update(position: queue_entry_data[:position], rating: queue_entry_data[:rating])
      end    
    end
  end
  
  def set_default_position
    current_user.queue_entries.count + 1
  end
  
  def set_video
    @video = Video.find params[:video_id]
  end
  
end
