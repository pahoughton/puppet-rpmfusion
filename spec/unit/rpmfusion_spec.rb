# rpmfusion_spec.rb - 2014-03-13 18:18
#
# Copyright (c) 2014 Paul Houghton <paul4hough@gmail.com>
#
require 'spec_helper'

[11,19,21].each { |frel|
  os='Fedora'
  describe 'rpmfusion', :type => :class do
    let(:facts) do {
        :osfamily               => 'RedHat',
        :operatingsystem        => os,
        :operatingsystemrelease => frel,
        :os_maj_version         => frel,
    } end 
    context "supports operating system: #{os} rel #{frel}" do
      it { should contain_class('rpmfusion') }
    end
  end
}
# Other RedHat systems 6
['CentOS'].each { |os|
  rrel=6
  describe 'rpmfusion', :type => :class do
    let(:facts) do {
        :osfamily               => 'RedHat',
        :operatingsystem        => os,
        :os_maj_version         => rrel,
    } end 
    context "supports operating system: #{os} rel #{rrel}" do
      it { should contain_class('rpmfusion') }
    end
  end
}
