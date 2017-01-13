require 'rails_helper'

RSpec.describe Day, type: :model do
  it 'seeds properly' do
    expect(Day.select('id').map{|d| d.id}).to eq((0..6).to_a)
  end
end