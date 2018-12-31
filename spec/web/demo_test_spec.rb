describe 'Demo Test', :feature => "Demo Test feature"   do
 before do
     #@landing_page = MARKETPLACE::LandingPage.new(logger: @logger)

  end

  it 'visit Facebook' do |t|
    t.step "Going to url" do |s|
      visit 'https://marketplace.weinvest-stage.net'
    end

    # @landing_page.login('sp@weinvest.net','weinvest123')
    t.step "Trying to login" do |s|
      MARKETPLACE::LandingPage.login('sp@weinvest.net','weinvest123')
      s.attach_file("The response", Base.instance.message_file("My dummy Message"))
      #sleep(3)
    end
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

