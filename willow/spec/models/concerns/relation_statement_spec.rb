require 'rails_helper'

describe RelationStatement do
  before do
    class ExampleWork < ActiveFedora::Base
      property :relation, predicate: ::RDF::Vocab::DC.relation, class_name:"RelationStatement"
      accepts_nested_attributes_for :relation
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a relation active triple resource with an id, label, url, identifier and relationship' do
    @obj = ExampleWork.new
    @obj.attributes = {
      relation_attributes: [
        {
          label: 'A relation label',
          url: 'http://example.com/relation',
          identifier: '123456',
          identifier_scheme: 'local',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.relation.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.relation.first.id).to include('#relation')
    expect(@obj.relation.first.label).to eq ['A relation label']
    expect(@obj.relation.first.url).to eq ['http://example.com/relation']
    expect(@obj.relation.first.identifier).to eq ['123456']
    expect(@obj.relation.first.identifier_scheme).to eq ['local']
    expect(@obj.relation.first.relationship_name).to eq ['Is part of']
    expect(@obj.relation.first.relationship_role).to eq ['http://example.com/isPartOf']
  end

  it 'defines qualifiers' do
    expect(RelationStatement.id_qualifiers).to be_kind_of Array
    expect(RelationStatement.id_qualifiers).not_to be_empty
  end
end
