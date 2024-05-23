package metric_stream

import (
	"path/filepath"
	"testing"

	"github.com/Excoriate/tftest/pkg/scenario"
	"github.com/stretchr/testify/assert"
)

const recipeDir = "../../examples/cloudwatch/metric-stream"
const fixtureDir = "fixtures"

func TestRecipeBasicRo(t *testing.T) {
	t.Parallel()
	workdir := filepath.Join(recipeDir, "basic")
	s, err := scenario.NewWithOptions(t, workdir, scenario.WithScannedTFVars(workdir, fixtureDir), scenario.WithParallel())

	assert.NoErrorf(t, err, "Failed to create scenario: %s", err)

	s.Stg.PlanStage(t, s.GetTerraformOptions())
}
