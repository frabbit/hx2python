package dart.math;

@:library("dart:math")
@:native("Random")
@:remove
class Random
{
    public function new(?seed:Int){}

/**
   * Generates a positive random integer uniformly distributed on the range
   * from 0, inclusive, to [max], exclusive.
   *
   * Implementation note: The default implementation supports [max] values
   * between 1 and ((1<<32) - 1) inclusive.
   */
    public function nextInt(max:Int):Int return null;

/**
   * Generates a positive random floating point value uniformly distributed on
   * the range from 0.0, inclusive, to 1.0, exclusive.
   */
    public function nextDouble():Float return null;

/**
   * Generates a random boolean value.
   */
    public function nextBool():Bool return null;
}
