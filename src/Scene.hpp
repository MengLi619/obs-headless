#pragma once

#include "Source.hpp"

class Scene {
public:
	Scene(std::string id, std::string name, Settings* settings, int index);
	~Scene();

	// Getters
	std::string Id() { return id; }
	std::string Name() { return name; }
	SourceMap Sources() { return sources; }
	obs_scene_t* GetScene() { return obs_scene; }
	bool IsStarted() { return started; }

	// Methods
	Source* GetSource(std::string source_id);
	Source* AddSource(std::string source_name, SourceType type, std::string source_url, std::string source_preview_url);
	Source* DuplicateSourceFromScene(Scene* scene, std::string source_id);
	Source* DuplicateSource(std::string source_id);
	grpc::Status RemoveSource(std::string source_id);
	grpc::Status RestartSource(std::string source_id);
	grpc::Status Start();
	grpc::Status Stop();
	grpc::Status UpdateProto(proto::Scene* proto_scene);

private:
	int index;
	std::string id;
	std::string name;
	bool started;
	obs_scene_t* obs_scene;
	SourceMap sources;
	Source* active_source;
	Settings* settings;
	uint64_t source_id_counter;
};

typedef std::map<std::string, Scene*> SceneMap;
