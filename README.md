AndroidXml
---------

    gem install android-xml

# Quick start

###### generate_xml.rb
```ruby
require 'android-xml'

AndroidXml.file('res/values/strings.xml') do
  resource do
    string(name: 'app_name') { 'AppityApp' }
  end
end

AndroidXml.write_all
```

    > ruby generate_xml.rb
    ✓ res/values/strings.xml

    > cat res/values/strings.xml
    <?xml version="1.0" encoding="utf-8"?>
    <!-- Do not edit this file. It was generated by AndroidXml -->
    <resources>
        <string name="app_name">AppityApp</string>
    </resources>

# About

With **AndroidXml** you can generate an XML file with much less fuss.  It will
take care of prefixing attributes with `android:` when required, it includes the
`<?xml ?>` tag, includes the `xmlns:` attribute on your root node (but only when
required)... all that good stuff!

You still need to understand the format that the various Android XML files
expect, but hopefully you get a good productivity boost.

# More examples

```ruby
# The dreaded AndroidManifest file!
AndroidXml.file('AndroidManifest.xml') do
  manifest package: 'com.your_name_here.AppityApp', versionCode: 1, versionName: 1.0 do
    uses_sdk minSdkVersion: 11

    application label: '@string/app_name', icon: '@drawable/ic_launcher' do
      activity name: 'MainActivity', label: '@string/app_name' do
        intent_filter do
          # these helpers are defined in `android-xml/defaults.rb`,
          # and you can easily add your own with an AndroidXml.setup block (see
          # below)
          main_action
          launcher_category
        end
      end

      activity name: 'DisplayMessageActivity',
        label: '@string/app_name',
        parentActivityName: 'com.your_name_here.AppityApp.MainActivity'
    end
  end
end

# You can generate multiple files from one .rb file
AndroidXml.file('res/values-jp/strings.xml') do
  resource do
    string(name: 'app_name') { 'アッピティアップ' }
  end
end

AndroidXml.write_all
```

# Helpers

Here's how we create the main_action helper, or if you need to specify that some
attributes don't need the `android:` prefix.

```ruby
AndroidXml.setup do
  # the hash syntax specifies the `shortcut => actual-tag-name`
  tag :main_action => 'action' do
    # then we can assign default attributes
    defaults name: 'android.intent.action.MAIN'
  end
  tag :style do
    # <style name="..."> is correct - NOT <style android:name="...">
    rename :name
  end

  # if you want to add your own shorthands, go nuts:
  tag :activity do
    rename :parent => :parentActivityName
  end

  # global changes
  all do
    rename :style  # always style="", never android:style=""
  end

  # adds the xmlns attribute to the root node, no matter WHAT the root node is
  root do
    defaults 'xmlns:android' => 'http://schemas.android.com/apk/res/android'
  end

  # disable the xmlns attribute on the resource node
  tag :resources do
    defaults 'xmlns:android' => nil
  end
end
```

# Errata

```ruby
# If you want to check the output before committing to `write_all`
AndroidXml.output_all

# If you want to wipe out all the defaults and settings
AndroidXml.reset

# If you want the defaults back
AndroidXml.setup_defaults
```
