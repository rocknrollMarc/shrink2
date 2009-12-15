module Platter

  class Step < ::ActiveRecord::Base
    include Platter::FeatureSummaryChangeObserver
    include Platter::Cucumber::Adapter::AstStepAdapter
    include Platter::Cucumber::Formatter::TextFormatter

    belongs_to :scenario, :class_name => "Platter::Scenario"
    acts_as_list :scope => :scenario

    validates_presence_of :text
    validates_length_of :text, :maximum => 256

    alias_attribute :calculate_summary, :text

    def feature
      scenario.feature
    end

    def folder
      scenario.folder
    end
    
  end

end
