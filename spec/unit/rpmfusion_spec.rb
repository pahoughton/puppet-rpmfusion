# rpmfusion_spec.rb - 2014-03-13 18:18
#
# Copyright (c) 2014 Paul Houghton <paul4hough@gmail.com>
#
require 'spec_helper'

$os_family = {
  'Fedora' => 'RedHat',
  'CentOS' => 'RedHat',
}
$os_release = {
  'Fedora' => '20',
  'CentOS' => '6',
}

['Fedora','CentOS'].each { |os|
  describe 'rpmfusion', :type => :class do
    let(:facts) do {
        :osfamily               => $os_family[os],
        :operatingsystem        => os,
        :operatingsystemrelease => $os_release[os],
        :os_maj_version         => $os_release[os],
    } end 
    context "supports operating system: #{os}" do
      context "default params" do
        it { should contain_class('rpmfusion') }
      end
    end
  end
}
