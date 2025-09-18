#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <iostream>
#include <string>
// Boost UUID includes
#include <boost/uuid/uuid.hpp>
#include <boost/uuid/uuid_generators.hpp>
#include <boost/uuid/uuid_io.hpp>
#include <boost/uuid/random_generator.hpp>
#include <boost/uuid/string_generator.hpp>


int generate()
{
    std::cout << "=== Boost UUID Examples ===" << std::endl;

    // 1. Генерация случайного UUID (версия 4)
    boost::uuids::random_generator gen;
    boost::uuids::uuid uuid1 = gen();
    std::cout << "Random UUID: " << uuid1 << std::endl;

    // 2. Создание UUID из строки
    try {
        boost::uuids::string_generator gen_str;
        boost::uuids::uuid uuid2 = gen_str("01234567-89ab-cdef-0123-456789abcdef");
        std::cout << "UUID from string: " << uuid2 << std::endl;
        
        // Проверка на nil (нулевой UUID)
        if (uuid2.is_nil()) {
            std::cout << "UUID is nil" << std::endl;
        } else {
            std::cout << "UUID is valid" << std::endl;
        }
    }
    catch (const std::exception& e) {
        std::cout << "Error parsing UUID string: " << e.what() << std::endl;
    }

    // 3. Создание nil UUID
    boost::uuids::uuid nil_uuid = boost::uuids::nil_uuid();
    std::cout << "Nil UUID: " << nil_uuid << std::endl;

    // 4. Сравнение UUID
    boost::uuids::uuid uuid3 = gen();
    boost::uuids::uuid uuid4 = gen();
    
    if (uuid3 != uuid4) {
        std::cout << "UUIDs are different" << std::endl;
    }

    // 5. Преобразование в строку
    std::string uuid_string = boost::uuids::to_string(uuid3);
    std::cout << "UUID as string: " << uuid_string << std::endl;

    // 6. Получение размера UUID (всегда 16 байт)
    std::cout << "UUID size: " << uuid3.size() << " bytes" << std::endl;

    // 7. Итерация по байтам UUID
    std::cout << "UUID bytes: ";
    for (auto it = uuid3.begin(); it != uuid3.end(); ++it) {
        printf("%02x ", static_cast<int>(*it));
    }
    std::cout << std::endl;

    // 8. Создание name-based UUID (версия 3 или 5)
    boost::uuids::string_generator gen_str;
    try {
        boost::uuids::uuid namespace_uuid = gen_str("6ba7b810-9dad-11d1-80b4-00c04fd430c8"); // UUID namespace
        boost::uuids::name_generator name_gen(namespace_uuid);
        boost::uuids::uuid name_uuid = name_gen("example.com");
        std::cout << "Name-based UUID: " << name_uuid << std::endl;
    }
    catch (const std::exception& e) {
        std::cout << "Error generating name-based UUID: " << e.what() << std::endl;
    }

    return 0;
}

int main(int argc, char *argv[])
{
    generate();
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("qt_app", "Main");

    return app.exec();
}
