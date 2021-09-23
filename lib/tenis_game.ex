defmodule TenisGame do
  @moduledoc """
  Documentation for `Tenisgame`.
  """

  alias TenisGame.{Game, Player}

  @score_names %{0 => "Love", 1 => "Fifteen", 2 => "Thirty", 3 => "Forty"}

  defguard is_winner?(player) when player.score > 3
  defguard is_deuce?(player1, player2) when player1.score >= 3 and player1.score == player2.score

  def start_game(player1, player2) do
    %Game{player1: player1, player2: player2}
  end

  def score(game, player) do
    cond do
      game.player1.name == player.name ->
        updated_player = %Player{player | score: game.player1.score + 1}

        %Game{game | player1: updated_player}

      game.player2.name == player.name ->
        updated_player = %Player{player | score: game.player2.score + 1}

        %Game{game | player2: updated_player}

      true ->
        game
    end
  end

  def result(%Game{player1: player1, player2: player2}) when is_deuce?(player1, player2) do
    "Deuce"
  end

  def result(%Game{player1: player1, player2: player2})
      when (player1.score > 3 or player2.score > 3) and
             abs(player1.score - player2.score) < 2 do
    advantage_player = Enum.max_by([player1, player2], & &1.score)

    "Advantage for #{advantage_player.name}!"
  end

  def result(%Game{player1: player1})
      when is_winner?(player1) do
    "#{player1.name} is the winner!"
  end

  def result(%Game{player2: player2})
      when is_winner?(player2) do
    "#{player2.name} is the winner!"
  end

  def result(game) do
    player1_score_name = player_score_name(game.player1)
    player2_score_name = player_score_name(game.player2)

    "#{player1_score_name}-#{player2_score_name}"
  end

  defp player_score_name(%Player{score: score}) do
    @score_names[score]
  end
end
