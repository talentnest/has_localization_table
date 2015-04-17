require 'spec_helper'

describe HasLocalizationTable do
  describe '.with_options' do
    before do
      HasLocalizationTable.configure do |c|
        c.locale_class = 'Locale'
      end
    end

    it 'should make the options available within the block' do
      HasLocalizationTable.with_options(locale_class: 'Language') do
        HasLocalizationTable.locale_class.must_equal 'Language'
      end
    end

    it 'should revert to the original option values after the block' do
      HasLocalizationTable.with_options(locale_class: 'Language') { }
      HasLocalizationTable.locale_class.must_equal 'Locale'
    end

    it 'should revert nil values' do
      HasLocalizationTable.with_options(fallback_locale: -> { }) { }
      HasLocalizationTable.fallback_locale.must_be_nil
    end

    it 'should revert values if an exception was raised in the block' do
      begin
        HasLocalizationTable.with_options(fallback_locale: -> * { }) do
          raise 'error!'
        end

      rescue => e
      end

      HasLocalizationTable.config.fallback_locale.must_be_nil
    end
  end
end