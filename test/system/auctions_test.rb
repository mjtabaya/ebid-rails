require "application_system_test_case"

class AuctionsTest < ApplicationSystemTestCase
  setup do
    @auction = auctions(:one)
  end

  test "visiting the index" do
    visit auctions_url
    assert_selector "h1", text: "Auctions"
  end

  test "creating a Auction" do
    visit auctions_url
    click_on "New Auction"

    fill_in "Bidding Expiration", with: @auction.bidding_expiration
    fill_in "Date Auctioned", with: @auction.date_auctioned
    fill_in "Status", with: @auction.status
    fill_in "User", with: @auction.user_id
    click_on "Create Auction"

    assert_text "Auction was successfully created"
    click_on "Back"
  end

  test "updating a Auction" do
    visit auctions_url
    click_on "Edit", match: :first

    fill_in "Bidding Expiration", with: @auction.bidding_expiration
    fill_in "Date Auctioned", with: @auction.date_auctioned
    fill_in "Status", with: @auction.status
    fill_in "User", with: @auction.user_id
    click_on "Update Auction"

    assert_text "Auction was successfully updated"
    click_on "Back"
  end

  test "destroying a Auction" do
    visit auctions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Auction was successfully destroyed"
  end
end
