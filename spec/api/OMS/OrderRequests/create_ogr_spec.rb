
describe 'create order_requests' , :feature => "test_feature_0"  do

  before do
    Airborne.configure do |config|
      config.base_url = 'http://coredev-oms-staging.weinvest.net/order_management_service/api/v1/order_requests'
      config.headers = { 'Authorization' => 'testqwe123' }
    end
    @test_data = Base.instance.runtime_data[:test_data].first
    @order_generation_request_params = @test_data[:create_order_generation_request_params]
    time = Time.now.nsec
    @create_order_request_params = eval(@test_data[:create_order_request_params].to_s.gsub("\"give_rt_time_data\"") { time }).with_indifferent_access

  end

  it 'should create order requests' do |t|

    t.step " Call to create order request" do |s|
      post '/', @create_order_request_params
      s.attach_file("The given params", Base.instance.message_file(@create_order_request_params,'json'))
    end

    t.step " should get success response for order requests" do |s|

      expect(json_body[:status]).to eq('success')
      expect(response.code).to eq(200)
      s.attach_file("The response", Base.instance.message_file(json_body,'json'))
    end

    t.step " Call to get all order request" do |s|
      get '/', { params: { all: 'true', page: 1 } }
    end

    t.step " should get created order request" do |s|
      s.attach_file("The get response", Base.instance.message_file(json_body,'json'))
      expect(response.code).to eq(200)
      expect(json_body[:records].first.with_indifferent_access).to include(@create_order_request_params.except('amount'))
      expect(json_body[:records].first[:amount].to_f).to eq(@create_order_request_params[:amount].to_f)
      Base.instance.add_runtime_data('order_request_id',json_body[:records].first[:id])
    end

    t.attach_file("The response", Base.instance.message_file(Base.instance.runtime_data,'json'))
  end

end
