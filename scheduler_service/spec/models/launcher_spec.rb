require 'rails_helper'

RSpec.describe Launcher, type: :model do
  it 'gives proper success response' do
    File.open("tmp/test.rb", 'w') {|f| f.write("puts 2+2*2") }
    expect(Launcher.start_task({executable_path: 'tmp/test.rb'})).to eq({:code=>"200", :body=>{:message=>"ok"}})
  end

  it 'handles bad files' do
    File.open("tmp/test.rb", 'w') {|f| f.write("begin 2+2*2") }
    expect(Launcher.start_task({executable_path: 'tmp/test.rb'})).to eq({:code=>"422", :body=>{:message=>"Error processing file tmp/test.rb :tmp/test.rb:1: syntax error, unexpected end-of-input, expecting keyword_end\nbegin 2+2*2\n           ^"}})
  end
end