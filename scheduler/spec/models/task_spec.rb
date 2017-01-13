require "rails_helper"

RSpec.describe Task, type: :model do

  it "has valid factory" do
    expect(FactoryGirl.build(:task)).to be_valid
  end

  it "validates fields" do
    %i[name executable_path token start_date end_date port].each do |field|
      expect(FactoryGirl.build(:task, field => "")).not_to be_valid
    end
  end

  it 'adds schedule' do
    task = FactoryGirl.build(:task)
    task.save
    task.add_schedule(1, ['2', '4', '6'])
    expect(task.schedules.first.day_id).to eq(1)
    expect(task.schedules.first.execution_hours).to eq("2,4,6")
  end

  it 'finds schedules' do
    FactoryGirl.build(:task).save
    FactoryGirl.build(:schedule).save
    expect(Task.find_schedules_for(10)).to eq({3=>[2, 3, 4]})
  end

  it 'finds responses' do
    FactoryGirl.build(:task).save
    FactoryGirl.build(:task_response_200).save
    expect(Task.find_responses_for(10)).to eq([{"created_at"=>2.days.ago.noon, "code"=>"200", "message"=>"ok"}])
  end
end
