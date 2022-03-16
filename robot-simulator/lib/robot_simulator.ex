defmodule RobotSimulator do
  defstruct direction: :north, position: {0, 0}

  @valid_instruction ["R", "L", "A"]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  def create(direction, position) do
    with {:ok, _position} <- validate_position(position),
         {:ok, _direction} <- validate_direction(direction) do
      %__MODULE__{
        direction: direction,
        position: position
      }
    end
  end

  def create(), do: %__MODULE__{}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  def simulate(%{direction: direction} = robot, "R") do
    case direction do
      :north -> Map.put(robot, :direction, :east)
      :east -> Map.put(robot, :direction, :south)
      :south -> Map.put(robot, :direction, :west)
      :west -> Map.put(robot, :direction, :north)
    end
  end

  def simulate(%{direction: direction} = robot, "L") do
    case direction do
      :north -> Map.put(robot, :direction, :west)
      :east -> Map.put(robot, :direction, :north)
      :south -> Map.put(robot, :direction, :east)
      :west -> Map.put(robot, :direction, :south)
    end
  end

  def simulate(%{direction: direction, position: {x, y}} = robot, "A") do
    case direction do
      :north -> Map.put(robot, :position, {x, y + 1})
      :east -> Map.put(robot, :position, {x + 1, y})
      :south -> Map.put(robot, :position, {x, y - 1})
      :west -> Map.put(robot, :position, {x - 1, y})
    end
  end

  def simulate(robot, []), do: robot

  def simulate(robot, instructions) when is_binary(instructions) do
    simulate(robot, String.graphemes(instructions))
  end

  def simulate(robot, [h | t]) when h in @valid_instruction do
    simulate(robot, h) |> simulate(t)
  end

  def simulate(_robot, _instruction) do
    {:error, "invalid instruction"}
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  def direction(%{direction: direction}), do: direction

  @doc """
  Return the robot's position.
  """
  def position(%{position: position}), do: position

  defp validate_position({x, y}) when is_integer(x) and is_integer(y) do
    {:ok, {x, y}}
  end

  defp validate_position(_invalid_position) do
    {:error, "invalid position"}
  end

  defp validate_direction(direction) when direction in [:north, :east, :west, :south] do
    {:ok, direction}
  end

  defp validate_direction(_invalid_direction) do
    {:error, "invalid direction"}
  end
end
