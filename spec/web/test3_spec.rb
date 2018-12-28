describe 'Demo Test 3' do
  before do
    # @landing_page = MARKETPLACE::LandingPage.new(logger: @logger)
   Base.instance.set_logger(@logger)
  end

  it 'visit Facebook' do
    visit 'https://marketplace.weinvest-stage.net'

   # @landing_page.login('sp@weinvest.net','weinvest123')
     MARKETPLACE::LandingPage.login('sp@weinvest.net','weinvest123')
    #sleep(3)
    for i in 0..50
      # @landing_page.log(2)
      MARKETPLACE::LandingPage.log(3)
      sleep(0.25)
    end
  end
end
