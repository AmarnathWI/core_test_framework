
describe 'UICatalog smoke test 2' do
  it 'should detect the nav bar and get some methods 2' do


    expect(Capybara.current_driver).to be :appium
    puts Capybara.current_session.driver
    Pages::Home.verify_nav_bar_present
    Pages::Home.move_to_element_Type('TextFields')
    Pages::Home.enter_text_roundedText_and_Password('normal','rounded','password')
    Pages::Home.go_back
    Pages::Home.move_to_element_Type('TextFields')
    # capy_driver = Capybara.current_session.driver

    # Call appium driver's methods
    # capy_driver.appium_driver.find_element(:name, 'TextFields').click
    # find(:name, 'TextFields').click
    # expect(capy_driver.find_custom(:name, '<enter text>').size).to be 3

    # # Get Appium::Capybara::Node elements
    # capy_driver.find_custom(:name, '<enter text>')[0].send_keys 'abc'

    # capy_driver.find_custom(:xpath, "//XCUIElementTypeTextField[@name='Rounded']")[0].send_keys 'abc'
  end
end
