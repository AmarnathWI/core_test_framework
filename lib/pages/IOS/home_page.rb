 module Pages
  class Home
    @navigation_bar="//XCUIElementTypeNavigationBar[@name='DATA']"
    @normal_text_filed='Normal'
    @back_button = "//XCUIElementTypeButton[@name='Back']"

    class << self
      include RSpec::Matchers
      include Capybara::DSL

      def verify_nav_bar_present
        puts "I ma here"
        puts Capybara.current_session.driver
       # expect(find(:xpath,@navigation_bar.sub('DATA','UICatalog'))).to be_truthy
      end

      def move_to_element_Type(type)
        find(:name, type).click
        expect(find(:xpath,@navigation_bar.sub('DATA',type))).to be_truthy
      end

      def enter_text_roundedText_and_Password(text,rounded_text,password_text)
        find(:accessibility_id, @normal_text_filed).set text
        find(:accessibility_id, 'Rounded').set rounded_text
        Capybara.current_session.driver.browser.hide_keyboard
        Capybara.current_session.driver.appium_driver.execute_script "mobile: swipe",direction: 'up'
        #JavascriptDriver.scroll_to(page.find(:accessibility_id, 'Secure'), visible: false)
        #find(:xpath, '//XCUIElementTypeApplication[@name="UICatalog"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeTable/XCUIElementTypeOther[1]')
        #binding.pry
        #page.execute_script "window.scrollBy(0,10000)"
        #Capybara.current_session.driver.execute_script("window.scrollBy(0,10000)")
        find(:accessibility_id, 'Secure').set password_text
        find(:accessibility_id, 'Secure').set password_text
      end

      def go_back
        find(:xpath, @back_button).click
      end
    end
  end
end
