# Generated via
#  `rails generate curation_concerns:work Work`

module CurationConcerns
  class WorksController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior
    # Adds Willow messages to the controller
    include Sufia::Notifications

    self.curation_concern_type = Work
  end
end
