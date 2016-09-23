require_relative "test_helper"

class CardDatabaseOriginsTest < Minitest::Test
  def setup
    @db = load_database("ori")
  end

  def test_other
    assert_search_results "other:cmc=3", "Chandra, Fire of Kaladesh", "Chandra, Roaring Flame", "Liliana, Defiant Necromancer", "Liliana, Heretical Healer", "Nissa, Sage Animist", "Nissa, Vastwood Seer"
    assert_search_results "other:(a:eric)", "Chandra, Fire of Kaladesh", "Chandra, Roaring Flame"
  end

  def test_is_primary
    assert_search_results "is:primary jace",
      "Jace's Sanctum",
      "Jace, Vryn's Prodigy"
    assert_search_results "not:primary jace",
      "Jace, Telepath Unbound"
  end
end
