# frozen_string_literal: true

require 'test_helper'

class ProjectEntryTest < ActiveSupport::TestCase
  test 'invalid missing name' do
    project_entry = ProjectEntry.new(name: nil)
    refute project_entry.valid?
    assert_not_nil project_entry.errors[:name]
  end

  test 'invalid missing url' do
    project_entry = ProjectEntry.new(url: nil)
    refute project_entry.valid?
    assert_not_nil project_entry.errors[:url]
  end

  test 'invalid missing language' do
    project_entry = ProjectEntry.new(language: nil)
    refute project_entry.valid?
    assert_not_nil project_entry.errors[:language]
  end

  test 'upsert should save correctly the results' do
    project_factory = { name: 'GithubProjectClient', language: 'MyString', url: 'localhost' }

    ProjectEntry.upsert_from_github(project_factory)
    assert_equal 'MyString', ProjectEntry.first.language
  end
end
