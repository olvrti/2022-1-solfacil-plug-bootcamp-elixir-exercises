defmodule BirdCount do
  def today([h | _t] = list) when is_list(list), do: h

  def today(_list), do: nil

  def increment_day_count([]), do: [1]

  def increment_day_count([h | t]), do: [h + 1] ++ t

  def has_day_without_birds?([]), do: false

  def has_day_without_birds?([0 | _t]), do: true

  def has_day_without_birds?([_h | t]), do: has_day_without_birds?(t)

  def total([]), do: 0

  def total([h]), do: h

  def total([h | [b | t]]), do: total([h + b] ++ t)

  def busy_days(list), do: busy_days(list, 0)

  def busy_days([], acc), do: acc

  def busy_days([h | t], acc) when h < 5, do: busy_days(t, acc)

  def busy_days([_h | t], acc), do: busy_days(t, acc + 1)
end
