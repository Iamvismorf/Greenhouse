pragma Singleton
import Quickshell
import "fuzzysort.js" as FuzzyBalls

Singleton {
    function go(...args) {
        return FuzzyBalls.go(...args);
    }
}
