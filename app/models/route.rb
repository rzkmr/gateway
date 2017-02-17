# frozen_string_literal: true
# == Schema Information
#
# Table name: services
#
#  id             :integer      not null, primary key
#  service_id     :string       not null
#  verb           :string       not null
#  url_pattern    :string       not null
#  version        :string       not null
#

class Route < ApplicationRecord
  belongs_to :service

end
