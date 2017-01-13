require "rails_helper"

RSpec.describe Schedule, type: :model do

  it "has valid factory" do
    FactoryGirl.build(:task).save
    expect(FactoryGirl.build(:schedule)).to be_valid
  end

  it "validates fields" do
    FactoryGirl.build(:task)
    %i[task_id day_id execution_hours].each do |field|
      expect(FactoryGirl.build(:schedule, field => "")).not_to be_valid
    end
  end

end
