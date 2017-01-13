require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  it "generates a correct class for response" do
    tr200=FactoryGirl.build(:task_response_200)
    tr400=FactoryGirl.build(:task_response_400)
    expect(task_response_class('')).to be_empty
    expect(task_response_class([tr200])).to eq('background-success clickable')
    expect(task_response_class([tr400])).to eq('background-fail clickable')
  end

  it "generates a correct response popover" do
    FactoryGirl.build(:task).save
    FactoryGirl.build(:task_response_200).save
    expect(task_response_popover(Task.find_responses_for(10))).to eq('2016-12-19 13:00:00</br> 200 ok')
  end

end