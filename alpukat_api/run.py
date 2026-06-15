import uvicorn
from app.config import get_settings

settings = get_settings()

if __name__ == "__main__":
    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",  # PENTING: 0.0.0.0 agar bisa diakses dari HP fisik di jaringan yang sama
        port=settings.app_port,
        reload=settings.app_env == "development",
        log_level="info",
    )