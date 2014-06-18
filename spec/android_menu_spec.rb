require 'android-xml'


describe 'Android menu files' do

  before do
    AndroidXml.reset
    AndroidXml.setup_defaults
  end

  it 'should generate a sensible menu.xml file' do
    xml = AndroidXml.file('res/menu/menu.xml') do
      menu do
        item id: '@+id/action_search',
          icon: '@drawable/ic_action_search',
          title: '@string/action_search',
          showAsAction: 'ifRoom'

        item id: '@+id/action_settings',
          title: '@string/action_settings',
          showAsAction: 'never'
      end
    end

    expect(xml.to_s).to eql <<-XML
<?xml version="1.0" encoding="utf-8"?>
<!-- Do not edit this file. It was generated by AndroidXml -->
<menu xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:id="@+id/action_search"
          android:icon="@drawable/ic_action_search"
          android:title="@string/action_search"
          android:showAsAction="ifRoom" />
    <item android:id="@+id/action_settings"
          android:title="@string/action_settings"
          android:showAsAction="never" />
</menu>
XML
  end

  it 'should generate a sensible strings.xml file' do
    xml = AndroidXml.file('res/values/strings.xml') do
      resources do
        string(name: 'app_name') { 'Harroo' }
        string(name: 'hello') { 'Well, Harroo!' }
        string(name: 'portrait') { 'portrait' }
        string(name: 'landscape') { 'landscape' }
        string(name: 'button_send') { 'Send' }
        string(name: 'action_search') { 'Search' }
        string(name: 'action_settings') { 'Settings' }
        string(name: 'title_activity_main') { 'MainActivity' }
      end
    end

    expect(xml.to_s).to eql <<-XML
<?xml version="1.0" encoding="utf-8"?>
<!-- Do not edit this file. It was generated by AndroidXml -->
<resources>
    <string name="app_name">Harroo</string>
    <string name="hello">Well, Harroo!</string>
    <string name="portrait">portrait</string>
    <string name="landscape">landscape</string>
    <string name="button_send">Send</string>
    <string name="action_search">Search</string>
    <string name="action_settings">Settings</string>
    <string name="title_activity_main">MainActivity</string>
</resources>
XML
  end

end
