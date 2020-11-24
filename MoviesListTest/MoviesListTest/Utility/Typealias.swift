//
//  Typealias.swift
//  MoviesListTest
//
//  Created by Sofiia Lushchanets on 24.11.2020.
//

/// Closure that has neither arguments, nor return type (void).
typealias ArgumentlessClosure = () -> Void

/// Closure that has single argument, but hasn't got a return type (void).
///
/// - Parameter arg: Closure argument.
typealias ArgumentedClosure<T> = (_ arg: T) -> Void
