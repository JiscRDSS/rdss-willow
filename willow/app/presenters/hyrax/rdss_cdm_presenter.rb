# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  class RdssCdmPresenter < Hyrax::WorkShowPresenter
    delegate :title, :object_description, :object_keywords, :object_category, :object_dates, to: :solr_document
  end
end
