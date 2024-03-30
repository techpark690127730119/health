// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$partStreamHash() => r'd6a6fb1ad46097a344e14a6035112cb2da264d4c';

/// See also [partStream].
@ProviderFor(partStream)
final partStreamProvider = AutoDisposeStreamProvider<List<PartData>>.internal(
  partStream,
  name: r'partStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$partStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PartStreamRef = AutoDisposeStreamProviderRef<List<PartData>>;
String _$exerciseStreamHash() => r'e8f815952b130a84d535a2427eb0a62d4fef2416';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [exerciseStream].
@ProviderFor(exerciseStream)
const exerciseStreamProvider = ExerciseStreamFamily();

/// See also [exerciseStream].
class ExerciseStreamFamily extends Family<AsyncValue<List<ExerciseData>>> {
  /// See also [exerciseStream].
  const ExerciseStreamFamily();

  /// See also [exerciseStream].
  ExerciseStreamProvider call({
    required String part,
  }) {
    return ExerciseStreamProvider(
      part: part,
    );
  }

  @override
  ExerciseStreamProvider getProviderOverride(
    covariant ExerciseStreamProvider provider,
  ) {
    return call(
      part: provider.part,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'exerciseStreamProvider';
}

/// See also [exerciseStream].
class ExerciseStreamProvider
    extends AutoDisposeStreamProvider<List<ExerciseData>> {
  /// See also [exerciseStream].
  ExerciseStreamProvider({
    required String part,
  }) : this._internal(
          (ref) => exerciseStream(
            ref as ExerciseStreamRef,
            part: part,
          ),
          from: exerciseStreamProvider,
          name: r'exerciseStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$exerciseStreamHash,
          dependencies: ExerciseStreamFamily._dependencies,
          allTransitiveDependencies:
              ExerciseStreamFamily._allTransitiveDependencies,
          part: part,
        );

  ExerciseStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.part,
  }) : super.internal();

  final String part;

  @override
  Override overrideWith(
    Stream<List<ExerciseData>> Function(ExerciseStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExerciseStreamProvider._internal(
        (ref) => create(ref as ExerciseStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        part: part,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<ExerciseData>> createElement() {
    return _ExerciseStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExerciseStreamProvider && other.part == part;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, part.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExerciseStreamRef on AutoDisposeStreamProviderRef<List<ExerciseData>> {
  /// The parameter `part` of this provider.
  String get part;
}

class _ExerciseStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<ExerciseData>>
    with ExerciseStreamRef {
  _ExerciseStreamProviderElement(super.provider);

  @override
  String get part => (origin as ExerciseStreamProvider).part;
}

String _$exerciseNotifierHash() => r'b3cf1661be8792c9a804bee990cc1a9a48836e28';

/// See also [ExerciseNotifier].
@ProviderFor(ExerciseNotifier)
final exerciseNotifierProvider =
    NotifierProvider<ExerciseNotifier, ExerciseState>.internal(
  ExerciseNotifier.new,
  name: r'exerciseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exerciseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExerciseNotifier = Notifier<ExerciseState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
