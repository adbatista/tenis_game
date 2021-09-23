defmodule TenisGameTest do
  use ExUnit.Case

  alias TenisGame.Player

  setup do
    player1 = %Player{name: "Julia"}
    player2 = %Player{name: "Leo"}

    game = TenisGame.start_game(player1, player2)
    %{game: game, player1: player1, player2: player2}
  end

  describe "result/1" do
    test "no points are earned return a Love-Love game", %{game: game} do
      assert TenisGame.result(game) == "Love-Love"
    end

    test "player one scores one point return a Fifteen-Love game", %{
      game: game,
      player1: player1
    } do
      game = TenisGame.score(game, player1)

      assert TenisGame.result(game) == "Fifteen-Love"
    end

    test "player one scores two points return a Thirty-Love game", %{
      game: game,
      player1: player1
    } do
      game =
        game
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)

      assert TenisGame.result(game) == "Thirty-Love"
    end

    test "player one scores three points return a Forty-Love game", %{
      game: game,
      player1: player1
    } do
      game =
        game
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)

      assert TenisGame.result(game) == "Forty-Love"
    end

    test "player one scores four points return the winner", %{
      game: game,
      player1: player1
    } do
      game =
        game
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)

      assert TenisGame.result(game) == "Julia is the winner!"
    end

    test "player two scores a point return a Love-Fifteen game", %{
      game: game,
      player2: player2
    } do
      game = TenisGame.score(game, player2)

      assert TenisGame.result(game) == "Love-Fifteen"
    end

    test "player two scores two points return a Love-Thirty game", %{
      game: game,
      player2: player2
    } do
      game =
        game
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)

      assert TenisGame.result(game) == "Love-Thirty"
    end

    test "player two scores three points return a Love-Forty game", %{
      game: game,
      player2: player2
    } do
      game =
        game
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)

      assert TenisGame.result(game) == "Love-Forty"
    end

    test "player two scores four points return the winner", %{
      game: game,
      player2: player2
    } do
      game =
        game
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)

      assert TenisGame.result(game) == "Leo is the winner!"
    end

    test "both players have same score of 3 or more points return a deuce", %{
      game: game,
      player1: player1,
      player2: player2
    } do
      game =
        game
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)

      assert TenisGame.result(game) == "Deuce"
    end

    test "player one has advantage return the advantage", %{
      game: game,
      player1: player1,
      player2: player2
    } do
      game =
        game
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)

      assert TenisGame.result(game) == "Advantage for Julia!"
    end

    test "player two has the advantage return the advantage", %{
      game: game,
      player1: player1,
      player2: player2
    } do
      game =
        game
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)

      assert TenisGame.result(game) == "Advantage for Leo!"
    end

    test "player one has more than 3 points and a diference greater than 2 points from player two return the winner",
         %{
           game: game,
           player1: player1,
           player2: player2
         } do
      game =
        game
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)

      assert TenisGame.result(game) == "Julia is the winner!"
    end

    test "player two has more than 3 points and a diference greater than 2 points from player one return the winner",
         %{
           game: game,
           player1: player1,
           player2: player2
         } do
      game =
        game
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player1)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)
        |> TenisGame.score(player2)

      assert TenisGame.result(game) == "Leo is the winner!"
    end
  end
end
