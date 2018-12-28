

describe 'sample spec' , :feature => "test_feature_0"  do

  before do
    Airborne.configure do |config|
      config.base_url = 'http://coredev-oms-staging.weinvest.net/order_management_service/api/v1/order_requests'
      config.headers = { 'Authorization' => 'testqwe123' }
    end
  end
  let(:header_params){ { 'Authorization' => 'testqwe123' } }

  it 'should get order requests' do |t|
    t.step " Call to get all order request" do |s|
      get '/'
    end

    t.step " should get all order requests" do |s|
      puts response.code
      puts json_body.first
    end
  end

  it 'should create order requests' do |t|
    params = {
      requester_id: 1,
      requester_type: 'DepositAllocation',
      goal_id: 6,
      strategy_id: 329,
      amount: 40000.0,
      currency: "USD",
      buy_sell: "buy"
    }
    t.step " Call to get all order request" do |s|
      post '/', params
    end

    t.step " should get all order requests" do |s|
      puts response.code
      puts response.body
    end

    t.step " Call to get all order request" do |s|
      get '/'
    end

    t.step " should get all order requests" do |s|
      puts response.code
      puts json_body.first
    end
  end
end
