require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page = pages(:one)
  end

  test "should get index" do
    get pages_url
    assert_response :success
  end

  test "should get new" do
    get new_page_url
    assert_response :success
  end

  test "should create page" do
    assert_difference('Page.count') do
      post pages_url, params: { page: { author_id: @page.author_id, body: @page.body, date_published: @page.date_published, native_id: @page.native_id, native_image_url: @page.native_image_url, native_page_url: @page.native_page_url, site_id: @page.site_id, teaser_img_url: @page.teaser_img_url, title: @page.title } }
    end

    assert_redirected_to page_url(Page.last)
  end

  test "should show page" do
    get page_url(@page)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_url(@page)
    assert_response :success
  end

  test "should update page" do
    patch page_url(@page), params: { page: { author_id: @page.author_id, body: @page.body, date_published: @page.date_published, native_id: @page.native_id, native_image_url: @page.native_image_url, native_page_url: @page.native_page_url, site_id: @page.site_id, teaser_img_url: @page.teaser_img_url, title: @page.title } }
    assert_redirected_to page_url(@page)
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      delete page_url(@page)
    end

    assert_redirected_to pages_url
  end
end
