defmodule Cell do

  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state \\ false) do
    {:ok, state}
  end

  def call(pid, func) do
    GenServer.call(pid, func)
  end

  @impl true
  def handle_call(:is_alive, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:will_live, neighbors}, _from, state) when is_list(neighbors) do
    new_state = neighbors
    |> Enum.sum
    |> next_state(state)
    {:reply, new_state, new_state}
  end

  @doc """

  ## Examples

      iex> Cell.next_state(false, 3)
      true
      iex> Cell.next_state(true, 1)
      false
      iex> Cell.next_state(true, 4)
      false
      iex> Cell.next_state(false, 2)
      false
      iex> Cell.next_state(true, 2)
      true

  """
  def next_state(live_neighbors, _alive = false) when live_neighbors == 3 do
    true
  end

  def next_state(live_neighbors, _alive = true) when live_neighbors > 3 do
    false
  end

  def next_state(live_neighbors, _alive = true) when live_neighbors < 2 do
    false
  end

  def next_state(_, alive) do
    alive
  end
end
