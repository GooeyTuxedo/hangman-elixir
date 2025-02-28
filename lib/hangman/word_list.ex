defmodule Hangman.WordList do
  @moduledoc """
  Provides a list of words for the Hangman game with different difficulty levels.
  """

  @doc """
  Returns a random word from the word list.
  If no difficulty is specified, it returns a random word from all difficulties.
  """
  def random_word do
    words()
    |> Enum.random()
    |> String.downcase()
  end

  @doc """
  Returns a random word with the specified difficulty.
  """
  def random_word(difficulty) when difficulty in [:easy, :medium, :hard] do
    difficulty
    |> words_by_difficulty()
    |> Enum.random()
    |> String.downcase()
  end

  @doc """
  Returns a list of words for the game.
  """
  def words do
    [
      # Common Animals
      "elephant", "giraffe", "penguin", "dolphin", "zebra", "kangaroo", "octopus", "rhinoceros",
      "squirrel", "hedgehog", "flamingo", "jaguar", "koala", "leopard", "panther",

      # Foods
      "spaghetti", "avocado", "croissant", "lasagna", "cucumber", "pineapple", "blueberry",
      "mozzarella", "cinnamon", "chocolate", "pancake", "sandwich", "asparagus", "watermelon",

      # Technology
      "computer", "keyboard", "monitor", "database", "algorithm", "internet", "encryption",
      "software", "website", "bluetooth", "podcast", "programming", "router", "javascript",

      # Science
      "molecule", "hydrogen", "quantum", "gravity", "ecosystem", "evolution", "asteroid",
      "chemistry", "biology", "astronomy", "physics", "microscope", "experiment", "laboratory",

      # Geography
      "mountain", "waterfall", "continent", "peninsula", "atlantic", "pacific", "volcano",
      "glacier", "equator", "archipelago", "plateau", "hemisphere", "desert", "canyon",

      # Sports
      "basketball", "football", "baseball", "volleyball", "swimming", "cricket", "badminton",
      "tennis", "skateboard", "marathon", "cycling", "archery", "gymnastics", "snowboard",

      # Music
      "guitar", "orchestra", "symphony", "melody", "percussion", "trumpet", "saxophone",
      "violin", "harmony", "keyboard", "microphone", "concert", "festival", "acoustic",

      # Literature
      "chapter", "paragraph", "character", "metaphor", "publisher", "library", "magazine",
      "fiction", "biography", "narrative", "fantasy", "poetry", "mystery", "adventure",

      # Household
      "furniture", "kitchen", "bathroom", "bedroom", "balcony", "bookshelf", "blanket",
      "carpet", "curtain", "cupboard", "cushion", "doorbell", "fireplace", "wardrobe",

      # Transport
      "airplane", "railway", "bicycle", "helicopter", "submarine", "motorcycle", "escalator",
      "elevator", "ambulance", "trolley", "tractor", "scooter", "canoe", "sailboat",

      # Professions
      "engineer", "teacher", "astronaut", "architect", "journalist", "carpenter", "detective",
      "electrician", "gardener", "librarian", "mechanic", "physician", "programmer", "scientist",

      # Weather
      "sunshine", "rainfall", "blizzard", "hurricane", "tornado", "lightning", "forecast",
      "overcast", "humidity", "drizzle", "thermostat", "barometer", "breeze", "climate",

      # Space
      "asteroid", "jupiter", "mercury", "neptune", "galaxy", "comet", "universe", "supernova",
      "satellite", "telescope", "astronaut", "constellation", "atmosphere", "meteorite",

      # Clothing
      "jacket", "sweater", "trousers", "umbrella", "backpack", "necklace", "sunglasses",
      "pajamas", "sandals", "bracelet", "earrings", "cardigan", "shoelace", "swimsuit",

      # Fruits
      "apricot", "banana", "coconut", "cranberry", "dragonfruit", "grapefruit", "kiwifruit",
      "lychee", "mango", "nectarine", "papaya", "passionfruit", "raspberry", "strawberry",

      # Vegetables
      "artichoke", "asparagus", "broccoli", "cabbage", "carrot", "celery", "eggplant",
      "garlic", "lettuce", "mushroom", "onion", "potato", "pumpkin", "spinach",

      # Colors
      "magenta", "turquoise", "lavender", "crimson", "emerald", "indigo", "sapphire",
      "amber", "bronze", "copper", "ivory", "maroon", "scarlet", "violet",

      # Countries
      "australia", "brazil", "canada", "denmark", "ethiopia", "finland", "germany",
      "iceland", "japan", "kenya", "malaysia", "netherlands", "portugal", "switzerland",

      # Cities
      "amsterdam", "barcelona", "chicago", "dublin", "florence", "geneva", "helsinki",
      "istanbul", "kyoto", "lisbon", "madrid", "oslo", "prague", "singapore",

      # Languages
      "arabic", "bengali", "cantonese", "dutch", "english", "french", "german",
      "hindi", "italian", "japanese", "korean", "mandarin", "portuguese", "spanish",

      # Fun words
      "bamboozle", "flabbergast", "hullabaloo", "kerfuffle", "lollygag", "malarkey",
      "nincompoop", "rigmarole", "shenanigan", "whippersnapper", "wisecrack", "brouhaha",

      # Elixir & programming related
      "elixir", "phoenix", "function", "pattern", "module", "process", "erlang", "actor",
      "pipeline", "immutable", "concurrent", "functional", "struct", "protocol", "genserver",
      "supervisor", "liveview", "binary", "sigil", "macro", "behaviours", "comprehension"
    ]
  end

  @doc """
  Returns a list of words filtered by difficulty level.
  """
  def words_by_difficulty(:easy) do
    # Words with 3-5 letters
    words()
    |> Enum.filter(fn word -> String.length(word) in 3..5 end)
  end

  def words_by_difficulty(:medium) do
    # Words with 6-8 letters
    words()
    |> Enum.filter(fn word -> String.length(word) in 6..8 end)
  end

  def words_by_difficulty(:hard) do
    # Words with 9+ letters
    words()
    |> Enum.filter(fn word -> String.length(word) >= 9 end)
  end
end
