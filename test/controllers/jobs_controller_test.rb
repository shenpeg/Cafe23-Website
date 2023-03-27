require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
    @job = FactoryBot.create(:job)
  end

  test "should get index" do
    get jobs_path
    assert_response :success
  end

  test "should get new" do
    get new_job_path
    assert_response :success
  end

  test "should get edit" do
    get edit_job_path(@job)
    assert_response :success
  end

  test "should create job" do
    assert_difference('Job.count') do
      post jobs_path, params: { job: { name: 'Make Hot Fudge', description: 'It goes well with ice cream', active: true  } }
    end
    assert_redirected_to jobs_path

    post jobs_path, params: { job: { name: nil, description: 'It goes well with ice cream', active: true  } }
    assert_template :new
  end

  test "should update job" do
    patch job_path(@job), params: { job: { name: @job.name, description: 'Most important job', active: true  } }
    assert_redirected_to jobs_path

    patch job_path(@job), params: { job: { name: nil, description: 'Most important job', active: true  } }
    assert_template :edit
  end

  test "should destroy job when appropriate" do
    assert_difference('Job.count', -1) do
      delete job_path(@job)
    end

    assert_redirected_to jobs_path
  end

  test "should not destroy job when in appropriate" do
    @store = FactoryBot.create(:store)
    @employee = FactoryBot.create(:employee)
    @pay_grade = FactoryBot.create(:pay_grade)
    @assignment = FactoryBot.create(:assignment, store: @store, employee: @employee, pay_grade: @pay_grade, start_date: 7.days.ago.to_date, end_date: nil)
    @shift = FactoryBot.create(:shift, assignment: @assignment, date: 3.days.ago.to_date, status: 'finished')
    @shift_job = FactoryBot.create(:shift_job, shift: @shift, job: @job)
    assert_difference('Job.count', 0) do
      delete job_path(@job)
    end
    assert_template :index
  end

  test "should be no show action for job" do
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "jobs", action: "show", id: "#{@job.id}") end
  end
end
