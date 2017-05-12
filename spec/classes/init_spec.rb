require 'spec_helper'
describe 'kylin' do
  context 'with default values for all parameters' do
    it { should contain_class('kylin') }
  end
end
