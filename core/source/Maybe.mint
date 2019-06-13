enum Maybe(a) {
  Just(a)
  Nothing
}

module Maybe {
  /* TODO: Deprecated, kept to avoid breaking changed */
  /* Returns nothing. */
  fun nothing : Maybe(a) {
    Maybe::Nothing
  }

  /* TODO: Deprecated, kept to avoid breaking changed */
  /* Returns a maybe containing just the given value. */
  fun just (value : a) : Maybe(a) {
    Maybe::Just(value)
  }

  /*
  Returns whether or not the maybe is just a value or not.

     Maybe.isJust(Maybe::Just("A")) == true
     Maybe.isJust(Maybe::Nothing)) == false
  */
  fun isJust (maybe : Maybe(a)) : Bool {
    case (maybe) {
      Maybe::Nothing => false
      Maybe::Just x => true
    }
  }

  /*
  Returns whether or not the maybe is just nothing or not.

    Maybe.isNothing(Maybe::Just("A")) == false
    Maybe.isNothing(Maybe::Nothing"A")) == false
  */
  fun isNothing (maybe : Maybe(a)) : Bool {
    case (maybe) {
      Maybe::Nothing => true
      Maybe::Just x => false
    }
  }

  /*
  Maps the value of a maybe.

    (Maybe::Just(1)
    |> Maybe.map((number : Number) : Number { number + 2 })) == 3
  */
  fun map (func : Function(a, b), maybe : Maybe(a)) : Maybe(b) {
    case (maybe) {
      Maybe::Nothing => Maybe::Nothing
      Maybe::Just x => Maybe::Just(func(x))
    }
  }

  /*
  Returns the value of a maybe or the given value if it's nothing.

    Maybe.withDefault("A", Maybe::Nothing)) == "A"
    Maybe.withDefault("A", Maybe::Just("B")) == "B"
  */
  fun withDefault (value : a, maybe : Maybe(a)) : a {
    case (maybe) {
      Maybe::Nothing => value
      Maybe::Just x => x
    }
  }

  /*
  Converts the maybe to a result using the given value as the error.

    Maybe.toResult("Error", Maybe::Nothing)) == Result.error("Error")
    Maybe.toResult("Error", Maybe::Just("A")) == Result.ok("A")
  */
  fun toResult (error : b, maybe : Maybe(a)) : Result(b, a) {
    case (maybe) {
      Maybe::Nothing => Result.error(error)
      Maybe::Just x => Result.ok(x)
    }
  }

  /*
  Flattens a nested maybe.

    (Maybe::Just(Maybe::Just("A"))
    |> Maybe.flatten()) == Maybe::Just("A")
  */
  fun flatten (maybe : Maybe(Maybe(a))) : Maybe(a) {
    case (maybe) {
      Maybe::Nothing => Maybe::Nothing
      Maybe::Just x => x
    }
  }

  /*
  Returns the first maybe with value of the array or nothing
  if it's all nothing.

    Maybe.oneOf([Maybe::Just("A"), Maybe::Nothing)]) == Maybe::Just("A")
  */
  fun oneOf (array : Array(Maybe(a))) : Maybe(a) {
    array
    |> Array.find((item : Maybe(a)) : Bool { Maybe.isJust(item) })
    |> flatten()
  }
}
