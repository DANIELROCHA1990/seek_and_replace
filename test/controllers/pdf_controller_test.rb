require "test_helper"

class PdfControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get pdf_search_url
    assert_response :success
  end

  test "should get replace" do
    get pdf_replace_url
    assert_response :success
  end
end
