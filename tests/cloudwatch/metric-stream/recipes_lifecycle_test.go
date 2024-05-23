package metric_stream

import (
	"path/filepath"
	"testing"

	"github.com/Excoriate/tftest/pkg/tfvars"

	"github.com/Excoriate/tftest/pkg/scenario"
	"github.com/stretchr/testify/assert"
)

func TestRecipeBasicLifecycle(t *testing.T) {
	t.Parallel()
	workdir := filepath.Join(recipeDir, "basic")
	tfVars, tfVarErr := tfvars.GetTFVarsFromWorkdir(filepath.Join(workdir, fixtureDir))
	assert.NoError(t, tfVarErr)

	for _, tfVar := range tfVars {
		s, err := scenario.NewWithOptions(t, workdir, scenario.WithVarFiles(workdir, filepath.Join(fixtureDir, tfVar)), scenario.WithParallel())
		assert.NoErrorf(t, err, "Failed to create scenario: %s", err)

		s.Stg.ApplyStage(t, s.GetTerraformOptions())
	}
}

func TestRecipesAdvancedLifecycle(t *testing.T) {
	t.Parallel()
	workdir := filepath.Join(recipeDir, "advanced")
	tfVars, tfVarErr := tfvars.GetTFVarsFromWorkdir(filepath.Join(workdir, fixtureDir))
	assert.NoError(t, tfVarErr)

	for _, tfVar := range tfVars {
		s, err := scenario.NewWithOptions(t, workdir, scenario.WithVarFiles(workdir, filepath.Join(fixtureDir, tfVar)), scenario.WithParallel())
		assert.NoErrorf(t, err, "Failed to create scenario: %s", err)

		s.Stg.ApplyStage(t, s.GetTerraformOptions())
	}
}
