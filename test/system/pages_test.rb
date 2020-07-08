require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  setup do
    @page = pages(:one)
  end

  test "visiting the index" do
    visit pages_url
    assert_selector "h1", text: "Pages"
  end

  test "creating a Page" do
    visit pages_url
    click_on "New Page"

    fill_in "Author", with: @page.author_id
    fill_in "Body", with: @page.body
    fill_in "Date published", with: @page.date_published
    fill_in "Native", with: @page.native_id
    fill_in "Native image url", with: @page.native_image_url
    fill_in "Native page url", with: @page.native_page_url
    fill_in "Site", with: @page.site_id
    fill_in "Teaser img url", with: @page.teaser_img_url
    fill_in "Title", with: @page.title
    click_on "Create Page"

    assert_text "Page was successfully created"
    click_on "Back"
  end

  test "updating a Page" do
    visit pages_url
    click_on "Edit", match: :first

    fill_in "Author", with: @page.author_id
    fill_in "Body", with: @page.body
    fill_in "Date published", with: @page.date_published
    fill_in "Native", with: @page.native_id
    fill_in "Native image url", with: @page.native_image_url
    fill_in "Native page url", with: @page.native_page_url
    fill_in "Site", with: @page.site_id
    fill_in "Teaser img url", with: @page.teaser_img_url
    fill_in "Title", with: @page.title
    click_on "Update Page"

    assert_text "Page was successfully updated"
    click_on "Back"
  end

  test "destroying a Page" do
    visit pages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Page was successfully destroyed"
  end
end
