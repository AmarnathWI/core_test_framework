describe 'Demo Test' do
 before do
     #@landing_page = MARKETPLACE::LandingPage.new(logger: @logger)

  end

  it 'visit Facebook' do
    visit 'https://marketplace.weinvest-stage.net'

    #@landing_page.login('sp@weinvest.net','weinvest123')

    #sleep(3)
    for i in 0..50
      # @landing_page.log(1)
      MARKETPLACE::LandingPage.log(1)
      sleep(0.25)
    end
  end
  # it 'visit google' do
  #   @logger.info('Atlast')
  #   visit 'https://www.google.com'
  # end
end

