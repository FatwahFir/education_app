import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/core/errors/exceptions.dart';
import 'package:job_landing_course/core/errors/failure.dart';
import 'package:job_landing_course/features/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:job_landing_course/features/on_boarding/data/repositories/on_boarding_repo_impl.dart';
import 'package:job_landing_course/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataSrc extends Mock implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource dataSource;
  late OnBoardingRepository repo;

  setUp(() {
    dataSource = MockLocalDataSrc();
    repo = OnBoardingRepoImpl(dataSource: dataSource);
  });

  test('Should subclass of [OnBoardingRepository]', () {
    expect(
      repo,
      isA<OnBoardingRepository>(),
    );
  });

  group(
    "cacheFirstTimer",
    () {
      test(
        "Should complete successfully when call [localDataSrc.cacheFirtsTimer]",
        () async {
          when(
            () => dataSource.cacheFirstTimer(),
          ).thenAnswer(
            (_) async => Future.value,
          );

          final res = await repo.cacheFirstTimer();

          expect(
            res,
            equals(
              const Right<dynamic, void>(null),
            ),
          );
        },
      );

      test(
        "Should return [CacheException] when call [localDataSrc.cacheFirtsTimer] "
        'not successful',
        () async {
          when(
            () => dataSource.cacheFirstTimer(),
          ).thenThrow(
            const CacheException(message: "Insufficient storage"),
          );

          final res = await repo.cacheFirstTimer();

          expect(
            res,
            equals(
              Left<CacheFailure, dynamic>(
                CacheFailure(
                  message: 'Insufficient storage',
                  statusCode: 500,
                ),
              ),
            ),
          );

          verify(() => dataSource.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
    },
  );
}

// void main() {
  // for (int i = 0; i < 5; i++) {
  //   var res = '';
  //   res = res + ' ' * (5 - i - 1); // Mengatur spasi
  //   res = res + '*' * (i * 2 + 1); // Menambahkan bintang
  //   print(res);
  // }

  // for (int i = 0; i < 5; i++) {
  //   var res = '';
  //   res = res + ' ' * i; // Mengatur spasi
  //   res = res + '*' * (5 - i); // Menambahkan bintang
  //   print(res);
  // }

  // for (int i = 0; i < 5; i++) {
  //   var res = '';
  //   res = res + ' ' * i; // Tambah spasi bertambah
  //   res = res + '*' * ((5 * 2 - 1) - i * 2); // Mengurangi jumlah bintang
  //   print(res);
  // }

  // var data = [
  //   {'name': 'Agus', 'age': 23},
  //   {'name': 'Jajang', 'age': 32},
  //   {'name': 'Kaskus', 'age': 21},
  //   {'name': 'Kirto', 'age': 27},
  // ];

  // var listCopy = List.of(data);

  // listCopy.sort((a, b) {
  //   return (a['age'] as int).compareTo(
  //       b['age'] as int); // Pastikan a['age'] dan b['age'] adalah int
  // });

  // Mengurutkan berdasarkan nama
  // listCopy.sort((a, b) {
  //   return (a['name'] as String).compareTo(
  //       b['name'] as String); // Pastikan a['name'] dan b['name'] adalah String
  // });

  // Membuat list kosong untuk menampung hasil yang terurut
  // var sortedList = [];

  // Menggunakan forEach untuk mengisi sortedList
  // data.forEach((person) {
  //   var age = person['age'];
  //   var index = 0;

  //   // Mencari posisi yang tepat untuk menyisipkan orang berdasarkan umur
  //   while (index < sortedList.length && sortedList[index]['age'] < age) {
  //     index++;
  //   }

  //   // Menyisipkan orang ke posisi yang tepat
  //   sortedList.insert(index, person);
  // });

  // data.forEach((person) {
  //   var name = person['name'];
  //   var index = 0;

  //   // Mencari posisi yang tepat untuk menyisipkan orang berdasarkan nama
  //   while (index < sortedList.length &&
  //       (sortedList[index]['name'] as String).compareTo(name as String) < 0) {
  //     index++;
  //   }

  //   // Menyisipkan orang ke posisi yang tepat
  //   sortedList.insert(index, person);
  // });

  // for (var person in sortedList) {
  //   print('${person['name']}: ${person['age']}');
  // }

//   void swapValues(int a, int b) {
//     print('Sebelum swap: a = $a, b = $b');

//     a = a + b; // Menjumlahkan kedua nilai
//     b = a - b; // Mengambil nilai asli a
//     a = a - b; // Mengambil nilai asli b

//     print('Setelah swap: a = $a, b = $b');
//   }

//   swapValues(5, 2);
// }
