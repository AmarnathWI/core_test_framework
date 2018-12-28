require 'airborne'
require 'json'

require "net/http"
require "uri"
require 'tempfile'

describe 'sample spec' , :feature => "test_feature_0"  do
  before(:step) do

  end

   it 'should validate types' do |t|
    a =2
    t.step " Call to get weather#{a}" do |s|
      get 'http://api.apixu.com/v1/current.json?',{'params' => { 'key' => '5492db7a4b4f4a28a4394714180910' , 'q'=>'Paris' } } #json api that returns { "name" : "John Doe" }

       s.attach_file("screenshot",Tempfile.new("test"))

    end

    t.attach_file("screenshot",Tempfile.new("test"))

  end

  it 'should validate values' ,:story => "Another Story" do |t|

    t.step "Call to verify JSON GET " do
      get 'https://jsonplaceholder.typicode.com/todos/1' #json api that returns { "name" : "John Doe" }
      puts JSON.pretty_generate(JSON.parse(response.body))
      expect_json(completed: false)
    end

  end

   it 'should post values' do
    response = Helper::RestApi.get('https://jsonplaceholder.typicode.com/todos/1')
    puts response.inspect
    puts JSON.pretty_generate(JSON.parse(response.body))
  end

   it 'should get with attributes values' do
    response = Helper::RestApi.get_attribs('https://api.apixu.com/v1/current.json',{'params'=> { 'key' => '5492db7a4b4f4a28a4394714180910' , 'q'=>'Paris'} } )

    puts response.code

    response =
    expect(JSON.parse(response.body)['current']['temp_c']).to eql(11.0)


  end
end
