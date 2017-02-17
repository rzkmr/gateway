# frozen_string_literal: true
# == Schema Information
#
# Table name: services
#
#  id         :integer      not null, primary key
#  name       :string       not null
#  url        :string       not null
#  token      :string
#

class Service < ApplicationRecord
  has_many :routes

end
