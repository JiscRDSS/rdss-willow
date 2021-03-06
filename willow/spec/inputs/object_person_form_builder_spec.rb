require_relative 'facets'

class ObjectPersonFormBuilderDummy
  attr_accessor :honorific_prefix, :given_name, :family_name, :mail
end

RSpec.describe ObjectPersonFormBuilder do
  context 'honorific_prefix' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_prefix, 'Honorific prefix', required: false
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_prefix
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_prefix(required: true), 'Honorific prefix', required: true
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_prefix(required: true)
    it_behaves_like 'input',     FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_prefix
    it_behaves_like 'named',      FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_prefix, :honorific_prefix
  end

  context 'given_name' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).given_name, 'Given name', required: true
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).given_name
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).given_name(required: false), 'Given name'
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).given_name(required: false)
    it_behaves_like 'input',     FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).given_name
    it_behaves_like 'named',      FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).given_name, :given_name
  end

  context 'family_name' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).family_name, 'Family name', required: true
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).family_name
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).family_name(required: false), 'Family name'
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).family_name(required: false)
    it_behaves_like 'input',     FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).family_name
    it_behaves_like 'named',      FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).family_name, :family_name
  end

  context 'mail' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).mail, 'Email address', required: true
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).mail
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).mail(required: false), 'Email address'
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).mail(required: false)
    it_behaves_like 'email',     FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).mail
    it_behaves_like 'named',      FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).mail, :mail
  end
end