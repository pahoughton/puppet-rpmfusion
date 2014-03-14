# rpmfusion-repo_spec.rb - 2014-03-14 04:04
#
# Copyright (c) 2014 Paul Houghton <paul4hough@gmail.com>
#
require 'spec_helper'


[11,19,21].each { |rel|
  os='Fedora'
  ros='fedora'
  describe 'rpmfusion::repo', :type => :define do
    let(:facts) do {
        :osfamily               => 'RedHat',
        :operatingsystem        => os,
        :operatingsystemrelease => rel,
        :os_maj_version         => rel,
    } end 
    context "supports operating system: #{os} rel #{rel}" do
      ['free-','nonfree-',].each { |type|
        ['','source-'].each { |sub|
          repo="#{type}#{ros}-#{sub}#{rel}"
          context "given repo '#{repo}'" do
            let(:title) { repo }
            let:params do {
                :type    => ros,
                :version => rel,
            } end
            it { should contain_yumrepo("rpmfusion-#{repo}").
              with( 'enabled' => 1 )
            }
          end
        }
        
        # these are all update repos
        ['released-','testing-'].each { |uset|
          ['','debug-','source-'].each { |usub|
            repo="#{type}#{ros}-updates-#{uset}#{usub}-#{rel}"
            context "given repo '#{repo}'" do
              let(:title) { repo }
              let:params do {
                  :type    => ros,
                  :version => rel,
              } end
              it { should contain_yumrepo("rpmfusion-#{repo}").
                with( 'enabled' => 1 )
              }
            end
          }
        }
      }
    end
  end
}
# Other RedHat systems 6
['CentOS'].each { |os|
  rel=6
  ros='el'
    describe 'rpmfusion::repo', :type => :define do
    let(:facts) do {
        :osfamily               => 'RedHat',
        :operatingsystem        => os,
        :operatingsystemrelease => rel,
        :os_maj_version         => rel,
    } end 
    context "supports operating system: #{os} rel #{rel}" do
      ['free-','nonfree-',].each { |type|
        ['','source-'].each { |sub|
          repo="#{type}#{ros}-#{sub}#{rel}"
          context "given repo '#{repo}'" do
            let(:title) { repo }
            let:params do {
                :type    => ros,
                :version => rel,
            } end
            it { should contain_yumrepo("rpmfusion-#{repo}").
              with( 'enabled' => 1 )
            }
          end
        }
        
        # these are all update repos
        ['released-','testing-'].each { |uset|
          ['','debug-','source-'].each { |usub|
            repo="#{type}#{ros}-updates-#{uset}#{usub}-#{rel}"
            context "given repo '#{repo}'" do
              let(:title) { repo }
              let:params do {
                  :type    => ros,
                  :version => rel,
              } end
              it { should contain_yumrepo("rpmfusion-#{repo}").
                with( 'enabled' => 1 )
              }
            end
          }
        }
      }
    end
  end
}
