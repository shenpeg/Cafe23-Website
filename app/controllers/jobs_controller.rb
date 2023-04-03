class JobsController <  ApplicationController
  before_action :check_login
  authorize_resource

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path, notice: 'Job was successfully created.'
    else
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path, notice: 'Job was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    if @job.shift_jobs.empty?
      @job.destroy
      flash[notice:] = "Job was successfully destroyed."
      redirect_to jobs_path
    else
      flash[:notice] = "Job could not be destroyed as it is associated with shifts."
      render :index
    end
  end

  private
    def job_params
      params.require(:job).permit(:name, :description, :active)
    end
end
