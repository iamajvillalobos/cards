defmodule Cards do
  @moduledoc """
    Provides method for creating and handling deck of cards
  """

  @doc """
    Returns a list of string representing a deck of playing cards

      deck = Cards.create_deck
      ["Ace of Spades", "Two of Spades", "Three of Spades",
      "Four of Spades", "Five of Spades", "Six of Spades",
      "Seven of Spades", "Eight of Spades", "Nine of Spades",
      "Jack of Diamonds" ]

  """
  def create_deck do
    values = [
      "Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight",
      "Nine", "Ten", "Jack", "Queen", "King"
    ]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end
  
  @doc """
    Returns a new shuffled deck

      deck = Cards.create_deck
      Cards.shuffle(deck)
      ["Four of Hearts", "Six of Diamonds","Ace of Spades"]

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Returns a boolean value if the card is in the deck

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
      iex> Cards.contains?(deck, "Jar of Hearts")
      false

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Returns a list of string representing the cards you have in hand.
    You can customize how many cards you want to receive by `hand_size`
    argument.

      iex> deck = Cards.create_deck
      iex> Cards.deal(deck, 2)
      ["Ace of Spades", "Two of Spades"]

  """
  def deal(deck, hand_size) do
    { hand, _ } = Enum.split(deck, hand_size)
    hand
  end

  @doc """
    Save a deck in your file system.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Load a deck from your file system.
  """
  def load(filename) do
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term(binary)
      { :error, _reason } -> "File not found!"
    end
  end

  @doc """
    Shortcut method to easily create a deck, shuffle and deal a hand.
    Returns a list of string representing the cards you have in hand.

      Cards.create_hand(3)
      ["Nine of Diamonds", "Queen of Spades", "Six of Spades"]

  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
