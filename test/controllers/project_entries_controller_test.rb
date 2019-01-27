# frozen_string_literal: true

require 'test_helper'
require 'mocha'
require 'net/http'

class ProjectEntriesControllerTest < ActionController::TestCase
  setup do
    @project_entry = project_entries(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'perform the default ' do
    get :default_search
    assert_redirected_to 'http://test.host/project_entries/index'
  end

  test 'show a entry correctly' do
    get :show, id: @project_entry.id
    assert_response :success
  end

  test 'should do a search in github' do
    get :search, term: 'ruby', format: 'js'
    assert_response :success
  end

  test 'clear all' do
    get :clear_all, format: 'js'
    assert_nil assigns(:project_entries)
  end
end
